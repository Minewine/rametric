document.getElementById('contactForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const message = document.getElementById('message').value.trim();
    
    // Email validation regex
    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

    // Form validation
    if (!name || !email || !message) {
        alert('Please fill out all fields.');
        return;
    }

    if (!emailPattern.test(email)) {
        alert('Please enter a valid email address.');
        return;
    }

    // Success message
    alert('Thank you, ' + name + '! Your message has been sent.');
    
    // Send email (simulated as a comment, adjust this part for actual email sending)
    /* 
    Example using an email-sending API like EmailJS
    emailjs.send('service_id', 'template_id', {
        name: name,
        email: email,
        message: message
    }).then(function(response) {
        console.log('SUCCESS!', response.status, response.text);
    }, function(error) {
        console.log('FAILED...', error);
    });
    */

    // Reset form after submission
    document.getElementById('contactForm').reset();
});

// Initialize AOS
AOS.init({
    duration: 1000,  // Animation duration in milliseconds
    once: true       // Whether animation should happen only once (on scroll)
});
