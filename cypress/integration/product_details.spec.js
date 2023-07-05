describe("Product details page", () => {
  beforeEach(() => {
    cy.seedAndVisit(); 
  });

  it("should navigate to product details page", () => {
    cy.get(".products article").first().click(); 
    cy.url().should("include", "/products/"); 
    cy.get(".product-detail").should("be.visible"); 
  });
});
