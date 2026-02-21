package com.oceanview.test;
import com.oceanview.model.User;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class UserTest {
    @Test void testConstructorAndGetters() {
        User user = new User(1, "admin", "pass123", "ADMIN");
        assertEquals("admin", user.getUsername());
        assertEquals("ADMIN", user.getRole());
    }
    @Test void testSetters() {
        User user = new User();
        user.setUsername("staff1");
        assertEquals("staff1", user.getUsername());
    }
    @Test void testEmptyConstructor() {
        User user = new User();
        assertNull(user.getUsername());
    }
}