describe('Products on Product Details', () => {
  beforeEach(() => {
    cy.visit('/');
    cy.contains("Jungle");
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("See details of product - Scented Blade", () => {
    cy.contains('Scented Blade').click()
    cy.get('.product-detail')
      .should('contain', 'Scented Blade')
      .should('contain', '18 in stock')
  });

  it("See details of product - Giant Tea", () => {
    cy.contains('Giant Tea').click()
    cy.get('.product-detail')
      .should('contain', 'Giant Tea')
      .should('contain', '0 in stock')
      .should('contain', 'Sold Out')
  });
})