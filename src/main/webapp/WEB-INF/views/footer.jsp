<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!-- Simple Footer with copyright only -->
<footer class="bg-light text-dark text-center py-3 mt-5 border-top">
    <div class="container-fluid">
        <p class="mb-0">&copy; 2025 Trading App. All rights reserved.</p>
    </div>
</footer>

<style>
footer {
    margin-top: auto;
    width: 100%;
}

/* Make footer stick to bottom */
body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

main {
    flex: 1;
}
</style>