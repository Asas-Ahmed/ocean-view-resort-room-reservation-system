// ==========================================
// Ocean View Resort - Unified UI Logic
// ==========================================

// Real-Time Loader Logic
(function() {
    const loader = document.getElementById("page-loader");

    // Hide loader when DOM is fully interactive
    window.addEventListener("load", () => {
        requestAnimationFrame(() => {
            loader.classList.add("loader-hidden");
        });
    });

    // Show loader on click of links
    document.addEventListener("click", (e) => {
        const link = e.target.closest("a");
        
        if (link && 
            link.href && 
            !link.href.includes("#") && 
            !link.href.startsWith("javascript:") &&
            link.target !== "_blank") {
            loader.classList.remove("loader-hidden");
        }
    });

    // Show loader when reserving/saving/deleting via forms
    document.addEventListener("submit", (e) => {
        if (!e.defaultPrevented) {
            loader.classList.remove("loader-hidden");
        }
    });

    // Fix for Browser Back Button (BFCache)
    window.addEventListener("pageshow", (event) => {
        if (event.persisted) {
            loader.classList.add("loader-hidden");
        }
    });
})();

// --- Updated Modal Functions (Triggers Loader on Confirm) ---
function showDeleteModal(guestName, deleteUrl) {
    const span = document.getElementById('guestNameSpan');
    const btn = document.getElementById('confirmDeleteBtn');
    const modal = document.getElementById('deleteModal');
    
    if (span) span.innerText = guestName;
    
    if (btn) {
        btn.onclick = function(e) {
            const loader = document.getElementById("page-loader");
            if(loader) loader.classList.remove("loader-hidden");
            window.location.href = deleteUrl;
        };
    }
    
    if (modal) modal.style.display = 'flex';
}

function showUserDeleteModal(username, deleteUrl) {
    const span = document.getElementById('staffNameSpan');
    const btn = document.getElementById('confirmDeleteBtn');
    const modal = document.getElementById('deleteModal');
    
    if (span) span.innerText = username;
    
    if (btn) {
        btn.onclick = function(e) {
            const loader = document.getElementById("page-loader");
            if(loader) loader.classList.remove("loader-hidden");
            window.location.href = deleteUrl;
        };
    }
    
    if (modal) modal.style.display = 'flex';
}

function checkDatabaseStatus() {
    const indicator = document.getElementById('db-status-indicator');
    if (!indicator) return;

    // Builds: /ocean-view-resort + /dbtest
    const realUrl = window.ResortConfig.contextPath + "/dbtest";
    
    fetch(realUrl)
        .then(response => {
            if (response.ok) return response.text();
            throw new Error('Database unreachable');
        })
        .then(data => {
            // SUCCESS: Change "Checking..." to "Online"
            indicator.className = 'indicator indicator-online';
            indicator.innerHTML = '<span>Database Online</span>';
        })
        .catch(error => {
            // FAILURE: Change "Checking..." to "Offline"
            console.error("DB Status Error:", error);
            indicator.className = 'indicator btn-delete';
            indicator.style.background = '#fff1f2';
            indicator.style.color = '#e11d48';
            indicator.innerHTML = '<span>Database Offline</span>';
        });
}

document.addEventListener("DOMContentLoaded", () => {
	checkDatabaseStatus();
    const currentUrl = window.location.href;
    const sidebarLinks = document.querySelectorAll(".sidebar a");
    sidebarLinks.forEach(link => {
        if (currentUrl.includes(link.getAttribute("href"))) {
            link.classList.add("active");
        }
    });
	
	// --- Scroll to Change Capacity Number ---
	const capacityInput = document.querySelector('input[name="newCapacity"]');

	if (capacityInput) {
	    capacityInput.addEventListener('wheel', function(e) {
	        e.preventDefault();
			
	        let currentValue = parseInt(this.value) || 1;

	        if (e.deltaY < 0) {
	            this.value = currentValue + 1;
	        } else {
	            if (currentValue > 1) {
	                this.value = currentValue - 1;
	            }
	        }
	    }, { passive: false });
	}

    // Global Professional Form Validation
    const forms = document.querySelectorAll("form");
    forms.forEach(form => {
        form.addEventListener("submit", function(e) {
            let isValid = true;
            
            // Required Field Check
            const requiredFields = form.querySelectorAll("[required]");
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    applyError(field);
                } else {
                    removeError(field);
                }
            });

            // Specific Date Validation (if present)
            const checkInInput = form.querySelector('input[name="checkInDate"]');
            const checkOutInput = form.querySelector('input[name="checkOutDate"]');
            if (checkInInput && checkOutInput && checkInInput.value && checkOutInput.value) {
                if (new Date(checkOutInput.value) <= new Date(checkInInput.value)) {
                    isValid = false;
                    applyError(checkOutInput);
                    alert("Operational Error: Check-out must be after check-in.");
                }
            }

            // Specific Contact Validation (if present)
            const contactInput = form.querySelector('input[name="contactNumber"]');
            if (contactInput && contactInput.value) {
                if (!/^\d{10}$/.test(contactInput.value)) {
                    isValid = false;
                    applyError(contactInput);
                    alert("Security Policy: Contact number must be exactly 10 digits.");
                }
            }

            // Password Policy Check (Staff Directory Page)
            const passInput = document.getElementById('passwordInput');
            if (passInput) {
                const actionInput = form.querySelector('input[name="action"]');
                const action = actionInput ? actionInput.value : null;

                if (!(action === 'update' && passInput.value === "")) {
                    if (passInput.value.length < 8 || !/[0-9]/.test(passInput.value)) {
                        isValid = false;
                        applyError(passInput);
                        alert("Security Policy: Password must be 8+ characters with at least one number.");
                    }
                }
            }

            if (!isValid) {
                e.preventDefault();
            }
        });
    });

    // Ultra-Fast Table Filtering
    const searchInputs = document.querySelectorAll(".table-search");
    searchInputs.forEach(input => {
        input.addEventListener("input", () => {
            const filter = input.value.toLowerCase();
            const targetTable = document.querySelector(input.dataset.table);
            if (!targetTable) return;

            const rows = targetTable.querySelectorAll("tbody tr");
            rows.forEach(row => {
                const text = row.innerText.toLowerCase();
                row.style.display = text.includes(filter) ? "" : "none";
            });
        });
    });

    // Auto-Dismissing Notifications
    const statusMsgs = document.querySelectorAll(".status-msg, .error-msg, .alert-success, .status-msg-error");
    statusMsgs.forEach(msg => {
        setTimeout(() => {
            msg.style.transition = "opacity 0.6s ease, transform 0.6s ease";
            msg.style.opacity = "0";
            msg.style.transform = "translateY(-10px)";
            setTimeout(() => msg.remove(), 600);
        }, 4000);
    });
});

// --- Modal Functions (Global Access) ---
function closeModal() {
    const modal = document.getElementById('deleteModal');
    if (modal) modal.style.display = 'none';
}

window.onclick = function(event) {
    const modal = document.getElementById('deleteModal');
    if (event.target == modal) closeModal();
}

// --- Password Strength Logic ---
function checkStrength(password) {
    const meter = document.getElementById('meterContainer');
    const bar = document.getElementById('strengthBar');
    const text = document.getElementById('strengthText');
    if (!meter) return;

    if (password.length === 0) {
        meter.style.display = 'none';
        return;
    }

    meter.style.display = 'block';
    let score = 0;
    if (password.length >= 8) score++;
    if (/[A-Z]/.test(password)) score++;
    if (/[0-9]/.test(password)) score++;
    if (/[^A-Za-z0-9]/.test(password)) score++;

    const layers = [
        { width: '25%', color: '#ef4444', label: 'Weak' },
        { width: '50%', color: '#f59e0b', label: 'Moderate' },
        { width: '75%', color: '#3b82f6', label: 'Strong' },
        { width: '100%', color: '#22c55e', label: 'Secure' }
    ];

    const result = (score > 0) ? layers[score - 1] : layers[0];
    if (bar) {
        bar.style.width = result.width;
        bar.style.background = result.color;
    }
    if (text) {
        text.innerText = result.label;
        text.style.color = result.color;
    }
}

// Helper UI Functions
function applyError(field) {
    field.style.borderColor = "#ef4444";
    field.classList.add("shake");
}
function removeError(field) {
    field.style.borderColor = "";
    field.classList.remove("shake");
}

// Utility: Shake animation CSS injection
const styleTag = document.createElement('style');
styleTag.innerHTML = `
    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-5px); }
        75% { transform: translateX(5px); }
    }
    .shake { animation: shake 0.2s ease-in-out 0s 2; }
`;
document.head.appendChild(styleTag);