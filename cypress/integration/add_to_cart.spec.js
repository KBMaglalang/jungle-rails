describe('Add to Cart', () => {
  beforeEach(() => {
    cy.visit('/');
    cy.contains("Jungle");
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("See cart count increases after clicking the add button", () => {
    cy.get('.products article').get('.button_to').first().submit()
    cy.get('a[href*="/cart"]').should('contain', 'My Cart (1)')
  });
})