package com.oceanview.dao;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import com.oceanview.model.User;
import org.junit.jupiter.api.Test;

class UserDAOTest {
    private final UserDAO userDAO = mock(UserDAO.class);

    @Test
    void testGetUserByUsername_Success() throws Exception {
        User mockUser = new User("admin", "hashed_pass", "ADMIN");
        when(userDAO.getUserByUsername("admin")).thenReturn(mockUser);

        User result = userDAO.getUserByUsername("admin");
        assertEquals("ADMIN", result.getRole());
    }

    @Test
    void testAddUser_ReturnsTrue() throws Exception {
        User newUser = new User("staff1", "pass123", "STAFF");
        when(userDAO.addUser(newUser)).thenReturn(true);

        assertTrue(userDAO.addUser(newUser));
    }

    @Test
    void testDeleteUser_NotFound() throws Exception {
        when(userDAO.deleteUser("nonexistent")).thenReturn(false);
        assertFalse(userDAO.deleteUser("nonexistent"));
    }
}