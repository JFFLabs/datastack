import os

FAB_API_SWAGGER_UI = True
FAB_ADD_SECURITY_API = True
RATELIMIT_STORAGE_URI = "redis://redis:6379"

FEATURE_FLAGS =  {
    "EMBEDDED_SUPERSET": True,
    "DASHBOARD_RBAC": True
}

TALISMAN_CONFIG = {
    "content_security_policy": {
        "base-uri": ["'self'"],
        "default-src": ["'self'"],
        "frame-ancestors": os.environ.get("ALLOW_EMBED_FROM", "*").split(" "),
        "img-src": [
            "'self'",
            "blob:",
            "data:",
            "https://apachesuperset.gateway.scarf.sh",
            "https://static.scarf.sh/",
            # "https://avatars.slack-edge.com", # Uncomment when SLACK_ENABLE_AVATARS is True
        ],
        "worker-src": ["'self'", "blob:"],
        "connect-src": [
            "'self'",
            "https://api.mapbox.com",
            "https://events.mapbox.com",
        ],
        "object-src": [
            "'none'"
        ],
        "style-src": [
            "'self'",
            "'unsafe-inline'",
        ],
        "script-src": [
            "'self'",
            "'strict-dynamic'"
        ],
    },
    "content_security_policy_nonce_in": ["script-src"],
    "force_https": False,
    "session_cookie_secure": True,
    "session_cookie_http_only": True,
    "session_cookie_samesite": "None"
}
