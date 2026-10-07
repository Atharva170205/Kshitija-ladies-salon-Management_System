package com.rt.Model;

public class Owner {

    private String name;
    private String username;
    private String password;

    public Owner() {
    }

    public Owner(
            String name,
            String username,
            String password) {

        this.name = name;
        this.username = username;
        this.password = password;
    }

    // =====================================================
    // NAME
    // =====================================================

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // =====================================================
    // USERNAME
    // =====================================================

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // =====================================================
    // PASSWORD
    // =====================================================

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}