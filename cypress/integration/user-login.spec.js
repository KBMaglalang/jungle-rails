describe('User Login and Sign Up', () => {
  beforeEach(() => {
    cy.visit('/');
    cy.contains("Jungle");
  })

  describe('User Login', () => {
    it("There is products on the page", () => {
      cy.get(".products article").should("be.visible");
    });
  
    it("See if the user login works with valid information", () => {
      cy.contains('Login').click();
      cy.get('#email').type('test@test.com')
      cy.get('#password').type('password')
      cy.contains('Submit').click()
      cy.contains('Submit').should("not.exist")
      cy.contains('Signed in as:').should("be.visible");
    });
  
    it("See if user cannot login with wrong email", () => {
      cy.contains('Login').click();
      cy.get('#email').type('asdf@asdf.com')
      cy.get('#password').type('password')
      cy.contains('Submit').should("exist")
      cy.contains('Signed in as:').should("not.exist")
    });
  
    it("See if user cannot login with wrong password", () => {
      cy.contains('Login').click();
      cy.get('#email').type('test@test.com')
      cy.get('#password').type('asdfasdf')
      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });
  
    it("See if user cannot login with empty email and password", () => {
      cy.contains('Login').click();
      cy.contains('Submit').click()
      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });
  })  

  describe('Sign up sequence', () => {
    it("There is products on the page", () => {
      cy.get(".products article").should("be.visible");
    });

    it("See if sign up works with valid information", () => {
      cy.contains('Signup').click();

      cy.get('#user_first_name').type('firstname')
      cy.get('#user_last_name').type('lastname')
      cy.get('#user_email').type('email@email.com')
      cy.get('#user_password').type('password')
      cy.get('#user_password_confirmation').type('password')

      cy.contains('Submit').click()

      cy.contains('Submit').should("not.exist")
      cy.contains('Signed in as:').should("be.visible");
    });

    it("See if sign up does not work if signing up with the same information", () => {
      cy.contains('Signup').click();

      cy.get('#user_first_name').type('firstname')
      cy.get('#user_last_name').type('lastname')
      cy.get('#user_email').type('email@email.com')
      cy.get('#user_password').type('password')
      cy.get('#user_password_confirmation').type('password')

      cy.contains('Submit').click()

      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });

    it("See if sign up fails with empty first name", () => {
      cy.contains('Signup').click();

      cy.get('#user_last_name').type('lastname')
      cy.get('#user_email').type('email1@email.com')
      cy.get('#user_password').type('password')
      cy.get('#user_password_confirmation').type('password')

      cy.contains('Submit').click()
      
      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });

    it("See if sign up fails with empty last name", () => {
      cy.contains('Signup').click();

      cy.get('#user_first_name').type('firstname')
      cy.get('#user_email').type('email2@email.com')
      cy.get('#user_password').type('password')
      cy.get('#user_password_confirmation').type('password')

      cy.contains('Submit').click()
      
      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });

    it("See if sign up fails with empty email", () => {
      cy.contains('Signup').click();

      cy.get('#user_first_name').type('firstname')
      cy.get('#user_last_name').type('lastname')
      cy.get('#user_password').type('password')
      cy.get('#user_password_confirmation').type('password')

      cy.contains('Submit').click()
      
      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });

    it("See if sign up fails with empty password", () => {
      cy.contains('Signup').click();

      cy.get('#user_first_name').type('firstname')
      cy.get('#user_last_name').type('lastname')
      cy.get('#user_email').type('email3@email.com')
      cy.get('#user_password_confirmation').type('password')

      cy.contains('Submit').click()
      
      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });

    it("See if sign up fails with empty password confirmation", () => {
      cy.contains('Signup').click();

      cy.get('#user_first_name').type('firstname')
      cy.get('#user_last_name').type('lastname')
      cy.get('#user_email').type('email4@email.com')
      cy.get('#user_password').type('password')

      cy.contains('Submit').click()
      
      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });

    it("See if sign up fails with password mismatch", () => {
      cy.contains('Signup').click();

      cy.get('#user_first_name').type('firstname')
      cy.get('#user_last_name').type('lastname')
      cy.get('#user_email').type('email5@email.com')
      cy.get('#user_password').type('password')
      cy.get('#user_password_confirmation').type('wrong password')

      cy.contains('Submit').click()
      
      cy.contains('Submit').should("be.visible")
      cy.contains('Signed in as:').should("not.exist")
    });
  })


  describe('Sign up and Login Sequence', () => {
    it("There is products on the page", () => {
      cy.get(".products article").should("be.visible");
    });

    it("See if sign up and login works with valid information", () => {
      cy.contains('Signup').click();

      cy.get('#user_first_name').type('firstname')
      cy.get('#user_last_name').type('lastname')
      cy.get('#user_email').type('email6@email.com')
      cy.get('#user_password').type('password')
      cy.get('#user_password_confirmation').type('password')

      cy.contains('Submit').click()

      cy.contains('Submit').should("not.exist")
      cy.contains('Signed in as:').should("be.visible");

      cy.contains('Logout').click()
      cy.contains('Login').click();

      cy.get('#email').type('email6@email.com')
      cy.get('#password').type('password')

      cy.contains('Submit').click()

      cy.contains('Submit').should("not.exist")
      cy.contains('Signed in as:').should("be.visible");
    });
  })
})