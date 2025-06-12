<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    * {
        box-sizing: border-box;
    }

    body, html {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

main {
    padding: 5rem 3rem 2rem;
    background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
    overflow-y: auto;
    text-align: left;
    max-width: 100%;
    margin: 1rem 50px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.08);
    border-radius: 20px;
    line-height: 2.2rem;
    position: relative;
}

main::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #007bff, #0056b3);
    border-radius: 20px 20px 0 0;
}

main p {
    font-size: 1.2rem;
    margin-bottom: 1.8rem;
    padding: 0.8rem 0;
    transition: all 0.3s ease;
    border-bottom: 1px solid rgba(0,123,255,0.1);
    position: relative;
}

main p:hover {
    transform: translateX(8px);
    color: #0056b3;
}

main p strong {
    display: inline-block;
    width: 160px;
    color: #0e1c36;
    font-weight: 600;
    position: relative;
}

main p strong::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg, #007bff, #0056b3);
    transition: width 0.4s ease;
}

main p:hover strong::after {
    width: 90%;
}

/* Profile image styling */
div[style*="text-align: center"] {
    text-align: center !important;
    margin-bottom: 3rem !important;
    position: relative;
}

div[style*="text-align: center"]::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 200px;
    height: 200px;
    background: radial-gradient(circle, rgba(0,123,255,0.1) 0%, transparent 70%);
    border-radius: 50%;
    animation: profileGlow 4s ease-in-out infinite;
}

@keyframes profileGlow {
    0%, 100% {
        transform: translate(-50%, -50%) scale(1);
        opacity: 0.6;
    }
    50% {
        transform: translate(-50%, -50%) scale(1.15);
        opacity: 0.2;
    }
}

div[style*="text-align: center"] img {
    width: 180px !important;
    height: 180px !important;
    border-radius: 50% !important;
    object-fit: cover !important;
    border: 5px solid #007bff !important;
    box-shadow: 0 12px 30px rgba(0,123,255,0.25) !important;
    transition: all 0.4s ease !important;
    position: relative !important;
    z-index: 2 !important;
}

div[style*="text-align: center"]:hover img {
    transform: scale(1.08);
    box-shadow: 0 16px 40px rgba(0,123,255,0.35) !important;
    border-color: #0056b3 !important;
}

.profile-details {
    margin-top: 2rem;
    padding: 1rem 0;
}

main button {
    background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
    border: none;
    padding: 14px 28px;
    border-radius: 30px;
    font-size: 1.1rem;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 2rem;
    box-shadow: 0 6px 20px rgba(0,123,255,0.3);
    position: relative;
    overflow: hidden;
    font-weight: 500;
    letter-spacing: 0.5px;
}

main button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    transition: left 0.6s ease;
}

main button:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(0,123,255,0.4);
}

main button:hover::before {
    left: 100%;
}

main button:active {
    transform: translateY(-1px);
}

/* Enhanced typography */
main p:nth-child(odd) {
    background: rgba(0,123,255,0.02);
    border-radius: 8px;
    padding: 1rem 1.2rem;
    margin: 0.5rem -1.2rem 1.8rem;
}

main p:nth-child(even) {
    padding-left: 0.5rem;
}

/* Profile Image Container with Hover Overlay */
.profile-image-container {
    position: relative;
    display: inline-block;
}

.profile-image-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    cursor: pointer;
    z-index: 3;
}

.profile-image-container:hover .profile-image-overlay {
    opacity: 1;
    visibility: visible;
}

.overlay-content {
    text-align: center;
    color: white;
}

.overlay-content i {
    font-size: 2rem;
    margin-bottom: 0.5rem;
    display: block;
}

.overlay-content span {
    font-size: 0.9rem;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* Upload Modal Styling */
.upload-modal {
    display: none;
    position: absolute;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(5px);
}

.modal-content {
    background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
    margin: 8% auto;
    padding: 0;
    border: none;
    border-radius: 20px;
    width: 90%;
    max-width: 500px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    position: relative;
    overflow: hidden;
    animation: modalSlideIn 0.4s ease-out;
}

@keyframes modalSlideIn {
    from {
        transform: translateY(-50px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

.modal-header {
    background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
    color: white;
    padding: 1.5rem;
    text-align: center;
    position: relative;
}

.modal-header h2 {
    margin: 0;
    font-size: 1.5rem;
    font-weight: 600;
}

.close-btn {
    position: absolute;
    right: 1rem;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: white;
    font-size: 1.5rem;
    cursor: pointer;
    width: 35px;
    height: 35px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
}

.close-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-50%) rotate(90deg);
}

.modal-body {
    padding: 2rem;
    text-align: center;
}

.upload-area {
    border: 2px dashed #007bff;
    border-radius: 15px;
    padding: 2rem;
    margin: 1rem 0;
    background: rgba(0, 123, 255, 0.05);
    transition: all 0.3s ease;
    cursor: pointer;
    position: relative;
}

.upload-area:hover {
    border-color: #0056b3;
    background: rgba(0, 123, 255, 0.1);
    transform: translateY(-2px);
}

.upload-area.dragover {
    border-color: #28a745;
    background: rgba(40, 167, 69, 0.1);
}

.upload-icon {
    font-size: 3rem;
    color: #007bff;
    margin-bottom: 1rem;
}

.upload-text {
    font-size: 1.1rem;
    color: #495057;
    margin-bottom: 0.5rem;
}

.upload-subtext {
    font-size: 0.9rem;
    color: #6c757d;
}

#imagePreview {
    max-width: 200px;
    max-height: 200px;
    border-radius: 15px;
    margin: 1rem 0;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    display: none;
}

.modal-footer {
    padding: 1.5rem 2rem;
    text-align: center;
    background: #f8f9fa;
    border-top: 1px solid rgba(0, 123, 255, 0.1);
}

.upload-btn, .cancel-btn {
    padding: 12px 30px;
    border: none;
    border-radius: 25px;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    margin: 0 0.5rem;
    position: relative;
    overflow: hidden;
}

.upload-btn {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
}

.upload-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
}

.upload-btn:disabled {
    background: #6c757d;
    cursor: not-allowed;
    transform: none;
}

.cancel-btn {
    background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
}

.cancel-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
}

/* Responsive design */
@media (max-width: 768px) {
    main {
        margin: 0 1rem;
        max-width: 95%;
        padding: 12rem 2rem 2rem;
    }
    
    main p strong {
        width: 130px;
    }
    
    div[style*="text-align: center"] img {
        width: 150px !important;
        height: 150px !important;
    }
    
    div[style*="text-align: center"]::before {
        width: 170px;
        height: 170px;
    }
}

@media (max-width: 480px) {
    main {
        margin: 0 0.5rem;
        padding: 10rem 1.5rem 2rem;
    }
    
    main p {
        font-size: 1.1rem;
        line-height: 1.8rem;
    }
    
    main p strong {
        width: 110px;
        display: block;
        margin-bottom: 0.3rem;
    }
    
    div[style*="text-align: center"] img {
        width: 130px !important;
        height: 130px !important;
    }
    
    div[style*="text-align: center"]::before {
        width: 150px;
        height: 150px;
    }
    
    main p:nth-child(odd) {
        margin: 0.5rem -1rem 1.5rem;
        padding: 0.8rem 1rem;
    }
} 
</style>
</head>
<body>
<jsp:include page="header.jsp" />

<main>

  <div style="text-align: center; margin-bottom: 2rem;">
    <div class="profile-image-container">
        <c:choose>
            <c:when test="${not empty profileImageBase64}">
                <img src="data:image/jpeg;base64,${profileImageBase64}"
                     alt="Profile Photo"
                     style="width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid #007bff;" />
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/images/defaut.jpg"
                     alt="Default Profile"
                     style="width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid #007bff;" />
            </c:otherwise>
        </c:choose>
        <div class="profile-image-overlay" onclick="openUploadModal()">
            <div class="overlay-content">
                <i class="fas fa-camera"></i>
                <span>Change Photo</span>
            </div>
        </div>
    </div>
</div>

<!-- Upload Modal -->
<div id="uploadModal" class="upload-modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2><i class="fas fa-camera" style="margin-right: 10px;"></i>Update Profile Picture</h2>
      <button class="close-btn" onclick="closeUploadModal()">
        <i class="fas fa-times"></i>
      </button>
    </div>
    <form id="profileUploadForm" enctype="multipart/form-data" action="/dpupdate" method="post">
      <div class="modal-body">
        <div class="upload-area" onclick="document.getElementById('profileImage').click()">
          <i class="fas fa-cloud-upload-alt upload-icon"></i>
          <div class="upload-text">Click to select image or drag & drop</div>
          <div class="upload-subtext">Supports: JPG, PNG, GIF (Max: 5MB)</div>
        </div>
        <input type="file" id="profileImage" name="profile" accept="image/*" style="display: none;" onchange="previewImage(this)">
        <img id="imagePreview" src="" alt="Preview">
      </div>
      <div class="modal-footer">
        <button type="button" class="cancel-btn" onclick="closeUploadModal()">
          <i class="fas fa-times" style="margin-right: 8px;"></i>Cancel
        </button>
        <button type="submit" class="upload-btn" id="submitBtn" disabled>
          <i class="fas fa-upload" style="margin-right: 8px;"></i>Upload Photo
        </button>
      </div>
    </form>
  </div>
</div>

<script>
// Modal Functions
function openUploadModal() {
    document.getElementById('uploadModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function closeUploadModal() {
    document.getElementById('uploadModal').style.display = 'none';
    document.body.style.overflow = 'auto';
    resetUploadForm();
}

// Close modal when clicking outside
window.onclick = function(event) {
    const modal = document.getElementById('uploadModal');
    if (event.target == modal) {
        closeUploadModal();
    }
}

// Preview selected image
function previewImage(input) {
    const preview = document.getElementById('imagePreview');
    const submitBtn = document.getElementById('submitBtn');
    
    if (input.files && input.files[0]) {
        const file = input.files[0];
        
        // Validate file size (5MB)
        if (file.size > 5 * 1024 * 1024) {
            alert('File size must be less than 5MB');
            input.value = '';
            return;
        }
        
        // Validate file type
        if (!file.type.match('image.*')) {
            alert('Please select a valid image file');
            input.value = '';
            return;
        }
        
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
            submitBtn.disabled = false;
        }
        reader.readAsDataURL(file);
    }
}

// Reset upload form
function resetUploadForm() {
    document.getElementById('profileUploadForm').reset();
    document.getElementById('imagePreview').style.display = 'none';
    document.getElementById('submitBtn').disabled = true;
}

// Submit profile image
function submitProfileImage() {
    const formData = new FormData();
    const fileInput = document.getElementById('profileImage');
    
    if (fileInput.files[0]) {
        formData.append('profileImage', fileInput.files[0]);
        
        // Show loading state
        const submitBtn = document.getElementById('submitBtn');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right: 8px;"></i>Uploading...';
        submitBtn.disabled = true;
        
        
        // For now, just show success message (remove this when implementing backend)
        setTimeout(() => {
            alert('Profile image upload feature ready! Connect to your backend.');
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
            closeUploadModal();
        }, 1500);
    }
}

// Drag and drop functionality
const uploadArea = document.querySelector('.upload-area');

['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
    uploadArea.addEventListener(eventName, preventDefaults, false);
});

function preventDefaults(e) {
    e.preventDefault();
    e.stopPropagation();
}

['dragenter', 'dragover'].forEach(eventName => {
    uploadArea.addEventListener(eventName, highlight, false);
});

['dragleave', 'drop'].forEach(eventName => {
    uploadArea.addEventListener(eventName, unhighlight, false);
});

function highlight(e) {
    uploadArea.classList.add('dragover');
}

function unhighlight(e) {
    uploadArea.classList.remove('dragover');
}

uploadArea.addEventListener('drop', handleDrop, false);

function handleDrop(e) {
    const dt = e.dataTransfer;
    const files = dt.files;
    document.getElementById('profileImage').files = files;
    previewImage(document.getElementById('profileImage'));
}
</script>
    
    <div class="profile-detail">
      <p><strong>Name:</strong> ${kyc.userFullName}</p>
      <p><strong>Username:</strong> ${userDetails.username}</p>
      <p><strong>Email:</strong> ${kyc.userEmail}</p>
      <p><strong>Gender :</strong> ${kyc.userGender}</p>
      <p><strong>Mobile :</strong> ${kyc.userMobile}</p>
      <p><strong>DOB :</strong> ${kyc.userDob}</p>
      <p><strong>Adress:</strong> ${kyc.userAddress}</p> 
       <p><strong>Nationality :</strong> ${kyc.userNationality}</p>
      
    </div>

</main>


<jsp:include page="footer.jsp" />

</body>
</html>