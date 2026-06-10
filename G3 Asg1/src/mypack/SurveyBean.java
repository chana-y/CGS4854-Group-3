package mypack;   // matches the package declaration in the source file

import java.io.Serializable;

public class SurveyBean implements Serializable {

    private String fullName;
    private String email;
    private String phone;
    private int age;
    private String gender;
    private String qualification;
    private String employment;
    private String[] skills;
    private int proficiency;
    private String comments;

    public SurveyBean() {}

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }

    public String getEmployment() { return employment; }
    public void setEmployment(String employment) { this.employment = employment; }

    public String[] getSkills() { return skills; }
    public void setSkills(String[] skills) { this.skills = skills; }

    public int getProficiency() { return proficiency; }
    public void setProficiency(int proficiency) { this.proficiency = proficiency; }

    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }
}