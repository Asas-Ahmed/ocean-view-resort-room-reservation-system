package com.oceanview.test;

import static org.junit.jupiter.api.Assertions.*;
import com.oceanview.util.DBConnection;
import org.junit.jupiter.api.Test;
import java.sql.Connection;

class DBConnectionTest {

	@Test
	void testSingletonInstance() throws Exception {
	    assertNotNull(DBConnection.getInstance());
	}

    @Test
    void testGetConnectionNotNull() throws Exception {
        Connection con = DBConnection.getInstance().getConnection();
        assertNotNull(con);
    }

    @Test
    void testConfigurationExists() {
        // Verify the DBConnection instance is successfully created
        assertDoesNotThrow(() -> DBConnection.getInstance());
    }
}