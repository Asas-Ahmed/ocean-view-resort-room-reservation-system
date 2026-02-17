<style>
/* --- Theme Toggle --- */
.theme-switch {
    position: relative;
    display: inline-block;
    width: 54px;
    height: 28px;
    flex-shrink: 0;
}

.theme-switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.slider {
    position: absolute;
    cursor: pointer;
    inset: 0;
    background: #e2e8f0;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    border-radius: 34px;
    border: 1px solid var(--border-soft);
}

.slider:before {
    position: absolute;
    content: "";
    height: 20px;
    width: 20px;
    left: 3px;
    bottom: 3px;
    background-color: white;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    border-radius: 50%;
    z-index: 5;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

input:checked + .slider {
    background: #1e293b;
    border-color: #334155;
}

input:checked + .slider:before {
    transform: translateX(26px);
}

/* --- CSS Icons --- */
.sun-icon, .moon-icon {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 12px;
    height: 12px;
    transition: all 0.4s ease;
}

.sun-icon {
    right: 8px;
    background: #fbbf24;
    border-radius: 50%;
    box-shadow: 0 0 6px #fbbf24;
    opacity: 1;
}

.moon-icon {
    left: 8px;
    background: transparent;
    border-radius: 50%;
    box-shadow: -3px 2px 0 0 #f8fafc;
    opacity: 0;
    transform: translateY(10px) rotate(-15deg);
}

input:checked + .slider .sun-icon {
    opacity: 0;
    transform: translateY(-25px);
}

input:checked + .slider .moon-icon {
    opacity: 1;
    transform: translateY(-50%) rotate(-15deg);
}

/* --- THE OVERLAY --- */
#fixed-theme-controller {
    position: fixed;
    bottom: 25px;
    right: 25px;
    z-index: 9999;
    background: var(--bg-card);
    padding: 10px 16px;
    border-radius: 50px;
    border: 1px solid var(--border-soft);
    display: flex;
    align-items: center;
    gap: 12px;
    box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.2);
    transition: var(--transition-smooth);
}

#fixed-theme-controller span {
    font-size: 0.7rem;
    font-weight: 700;
    color: var(--text-muted);
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

#fixed-theme-controller:hover {
    transform: translateY(-3px);
    border-color: var(--brand-primary) !important;
    box-shadow: 0 10px 20px rgba(0,0,0,0.15);
}
</style>

<div id="fixed-theme-controller">
    <span>Mode</span>
    <label class="theme-switch">
        <input type="checkbox" id="dark-mode-checkbox">
        <div class="slider">
            <div class="moon-icon"></div>
            <div class="sun-icon"></div>
        </div>
    </label>
</div>

<script>
    (function() {
        const toggle = document.querySelector('#dark-mode-checkbox');
        const html = document.documentElement;

        // Sync the checkbox state with the theme set by the Head Script
        if (html.getAttribute('data-theme') === 'dark') {
            toggle.checked = true;
        }

        // Handle the manual clicks
        toggle.addEventListener('change', () => {
            if (toggle.checked) {
                html.setAttribute('data-theme', 'dark');
                localStorage.setItem('theme', 'dark');
            } else {
                html.setAttribute('data-theme', 'light');
                localStorage.setItem('theme', 'light');
            }
        });
    })();
</script>