# Create User Flow

## Objective

Register new users in the marketplace system, automatically determining if they are natural persons or legal entities based on their document type.

## Business Rules

1. **User Type Determination**
   - Document type `V` (Venezolano) → Natural Person
   - Document type `J` (Jurídico) → Legal Entity (Company)

2. **Required Data**
   - **For all users:**
     - Email (unique)
     - Phone (unique, international format)
     - Password hash
     - Document type and number (unique)
     - Township (location)
   - **For Natural Persons (V):**
     - First name (required)
     - Surname (required)
     - Middle name (optional)
     - Second surname (optional)
     - Birthdate (optional)
   - **For Legal Entities (J):**
     - Company name (required)

3. **Default Values**
   - Role: Common user (role_id = 1)
   - Verified status: false
   - Reputation level: New (reputation_level_id = 1)

## Tables Involved

1. **`app_user`**: Core user authentication and authorization data
2. **`person`**: Natural person-specific data
3. **`company`**: Legal entity-specific data
4. **`township`**: User location reference
5. **`role`**: User permission level
6. **`reputation_level`**: User reputation status

## Process Steps

### 1. Input Validation

```sql
IF document_type = 'J' AND company_name IS NULL THEN
    → Error: Company name required
END IF

IF document_type = 'V' AND (first_name IS NULL OR surname IS NULL) THEN
    → Error: First name and surname required
END IF
```

### 2. Create App User Record

```sql
INSERT INTO app_user (
    role_id,
    email,
    phone,
    password_hash,
    document_type,
    document_number,
    township_id
)
```

### 3. Create Type-Specific Record

**For Natural Persons:**

```sql
INSERT INTO person (
    app_user_id,
    first_name,
    middle_name,
    surname,
    second_surname,
    birthdate
)
```

**For Legal Entities:**

```sql
INSERT INTO company (
    app_user_id,
    company_name
)
```

### 4. Return User UUID

Function returns the `app_user_id` for use in subsequent operations.

## Key Validations

1. **Uniqueness**: Email, phone, and document number must be unique
2. **Foreign Keys**: Role and township must exist
3. **Phone Format**: Must match international format `^\+[1-9][0-9]{7,14}$`
4. **Document Type**: Must be 'V' or 'J'
5. **Type-Specific Requirements**: Enforced based on document type

## Error Handling

| Error Type            | Cause                          | Message                                                                  |
| --------------------- | ------------------------------ | ------------------------------------------------------------------------ |
| Validation Error      | Missing required fields        | "Company name is required..." / "First name and surname are required..." |
| Unique Violation      | Duplicate email/phone/document | "User with this email, phone, or document number already exists"         |
| Foreign Key Violation | Invalid role_id or township_id | "Invalid reference: check role_id and township_id"                       |
| Other                 | Unexpected database error      | "Error creating user: [details]"                                         |

## Usage Examples

See [`tests/test_create_user.sql`](../tests/test_create_user.sql) for complete test cases.

## Related Functions

- `update_timestamp()`: Automatically updates `updated_at` field

## Implementation Notes

1. **Transaction Safety**: Function uses implicit transaction, rolls back on error
2. **Password Security**: Function expects pre-hashed password (argon2)
3. **Extensibility**: Easy to add more person/company fields as needed
4. **Atomic Operation**: User creation is all-or-nothing across related tables
