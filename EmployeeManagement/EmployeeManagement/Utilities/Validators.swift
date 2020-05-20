import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case employeename
    case salary
    case projectIdentifier
    case requiredField(field: String)
    case age
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .employeename: return EmployeeNameValidator()
        case .salary:return SalaryValidator()
        case .projectIdentifier: return ProjectIdentifierValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .age: return AgeValidator()
            
        }
    }
}


struct ProjectIdentifierValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z]{1}[0-9]{1}[-]{1}[0-9]{3}[A-Z]$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Project Identifier Format")
            }
        } catch {
            throw ValidationError("Invalid Project Identifier Format")
        }
        return value
    }
}


class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!")}
        guard age >= 21 else {throw ValidationError("You have to be over 21 years old :)")}
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct EmployeeNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 4 else {
            throw ValidationError("Employee name must contain more than four characters" )
        }
        guard value.count < 25 else {
            throw ValidationError("Employee name shoudn't conain more than 25 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-zA-Z][a-zA-Z /\\;:.,()]*",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Employee name, Employee name should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid Employee name, Employee name should not contain whitespaces,  or special characters")
        }
        return value
    }
}

struct SalaryValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Employee salary is required")}
        guard let salary = Int(value) else {throw ValidationError("Employee salary must be a number!")}
        guard value.count < 500 else {throw ValidationError("Invalid Employee salary!")}
        guard salary >= 1000 else {throw ValidationError("Employee salary have to be over 1000 rupees)")}
        return value
    }
}


