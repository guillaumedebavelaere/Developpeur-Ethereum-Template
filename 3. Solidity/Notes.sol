// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import '@openzeppelin/contracts/access/Ownable.sol';

contract Grades is Ownable {

    enum Subject {
        FR, MATH, BIO
    }


    mapping(string => Student) _studentsMapping;
    mapping(string => Student[]) private _classesStudents;
    mapping(string => mapping(address => Teacher)) private _classesTeachers;

    mapping(address => bool) private _allowedTeachers;

    struct Teacher {
        address _address;
        Subject subject;
    }

    struct Student {
        string name;
        uint noteBiology;
        uint noteMath;
        uint noteFr;
    }

    modifier onlyTeacher() {
        require(_allowedTeachers[msg.sender], "Only teachers are allowed!");
        _;
    }

    function addTeacher(string memory _className, address _teacherAddress, Subject _subject) external onlyOwner {
         _classesTeachers[_className][_teacherAddress] = Teacher(_teacherAddress, _subject);
    }
    

    function addGrade(uint _grade, string calldata _className, string calldata _studentName) external onlyTeacher {
        require(_classesTeachers[_className][msg.sender]._address == msg.sender, "teacher doesn't belong to this class!");  
        Student memory student = _studentsMapping[_studentName];
        // if it is a new students, add it to the list
        if (keccak256(bytes(student.name)) == keccak256(bytes(""))) {
            _classesStudents[_className].push(student);
        }
        student.name = _studentName;
        Subject subject = _classesTeachers[_className][msg.sender].subject;
        if (subject == Subject.FR) {
            student.noteFr = _grade;
        } else if (subject == Subject.MATH) {
            student.noteMath = _grade;
        } else if (subject == Subject.BIO) {
            student.noteBiology = _grade;
        }
    }

    function getStudentGradeAvg(string memory _studentName) public view returns (uint) {
        Student memory student = _studentsMapping[_studentName];
        return (student.noteBiology + student.noteMath + student.noteFr) / 3;
    }

    function getSubjectClassGrade(string memory _className, Subject _subject) external view returns (uint) {
        uint totalGrades;
        Student[] memory students = _classesStudents[_className];
        for (uint i =0; i < students.length; i++) {
            if (_subject == Subject.BIO) {
                totalGrades += students[i].noteBiology;
            }
            if (_subject == Subject.MATH) {
                totalGrades += students[i].noteMath;
            }
            if (_subject == Subject.FR) {
                totalGrades += students[i].noteFr;
            }
        }

        return totalGrades / students.length;
        
    }

    function getClassGradeAvg(string memory _className) external view  returns(uint) {
        uint totalGrades;
        Student[] memory students = _classesStudents[_className];
        for (uint i =0; i < students.length; i++) {
            totalGrades += getStudentGradeAvg(students[i].name);
        }

        return totalGrades / students.length;
    }

    function hasGraduated(string memory _studentName) external view  returns(bool){
        return getStudentGradeAvg(_studentName) >= 10;
    }
}