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
    case projectname
    case designation
    case requiredField(field: String)
    case band
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .employeename: return EmployeeNameValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .band: return BandValidator()
        case .projectname:return ProjectNameValidator()
        case .designation:return DesignationValidator()
            
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



class BandValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("band is required")}
        guard value.count <= 2 else {throw ValidationError("Invalid band name!")}
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

struct ProjectNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 1 else {
            throw ValidationError("Project name must contain more than one characters" )
        }
        guard value.count < 61 else {
            throw ValidationError("Project name shoudn't conain more than 60 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-zA-Z][a-zA-Z /\\;:.,()]*",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Project name, Project name should not contain special characters")
            }
        } catch {
            throw ValidationError("Invalid Project name, Project name should not contain special characters")
        }
        return value
    }
}

struct DesignationValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 4 else {
            throw ValidationError("Designation must contain more than four characters" )
        }
        guard value.count < 31 else {
            throw ValidationError("Designation shoudn't conain more than 30 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-zA-Z][a-zA-Z /\\;:.,()]*",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Designation, Designation should not contain numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid Designation, Designation should not contain numbers or special characters")
        }
        return value
    }
}





