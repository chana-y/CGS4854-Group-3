package mypack; // Required package structure [cite: 83]

import java.sql.*;
import java.io.Serializable;


public class SurveyBean implements Serializable {
    private int id;
    private String fullName, email, phone, gender, qualification, employment, skills, comments, resume;
    private int age, proficiency;
    private String errorMessage; // Added to store error messages for debugging

    // Getters and Setters [cite: 87]
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }
    public String getEmployment() { return employment; }
    public void setEmployment(String employment) { this.employment = employment; }
    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }
    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }
    public String getResume() { return resume; }
    public void setResume(String resume) { this.resume = resume; }
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    public int getProficiency() { return proficiency; }
    public void setProficiency(int proficiency) { this.proficiency = proficiency; }
    public String getErrorMessage() {
        return errorMessage;
    }
    // JDBC Connection handling [cite: 89]
    public Connection getConnection() throws SQLException, ClassNotFoundException {
    // This line tells Java to look into the .jar file for the driver
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    return DriverManager.getConnection("jdbc:mysql://localhost:3306/surveydb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true", "root", "chanelyoung123");
}

    // Insert new survey record [cite: 89]
 public boolean saveSurvey() {
    String query = "INSERT INTO survey_data (fullName, email, phone, gender, qualification, employment, skills, proficiency, comments, resume) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
        ps.setString(1, fullName);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, gender);
        ps.setString(5, qualification);
        ps.setString(6, employment);
        ps.setString(7, skills);
        ps.setInt(8, proficiency);
        ps.setString(9, comments);
        ps.setString(10, resume);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
    System.out.println("DEBUG ERROR DETECTED: " + e.getMessage());
    e.printStackTrace(System.out);

    // Save the specific error message to our new variable
    this.errorMessage = e.getMessage(); 
    return false;
    }
}


    // Fetches record details into the bean's fields [cite: 92]
    public boolean retrieveSurvey(String targetEmail) {
        String query = "SELECT * FROM survey_data WHERE email = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, targetEmail);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.id = rs.getInt("id");
                this.fullName = rs.getString("fullName");
                this.email = rs.getString("email");
                this.phone = rs.getString("phone");
                this.gender = rs.getString("gender");
                this.qualification = rs.getString("qualification");
                this.employment = rs.getString("employment");
                this.skills = rs.getString("skills");
                this.proficiency = rs.getInt("proficiency");
                this.comments = rs.getString("comments");
                this.resume = rs.getString("resume");
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Updates existing data based on email [cite: 91]
    public boolean updateSurvey() {
        String query = "UPDATE survey_data SET fullName=?, phone=?, gender=?, qualification=?, employment=?, skills=?, proficiency=?, comments=? WHERE email=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, gender);
            ps.setString(4, qualification);
            ps.setString(5, employment);
            ps.setString(6, skills);
            ps.setInt(7, proficiency);
            ps.setString(8, comments);
            ps.setString(9, email);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}