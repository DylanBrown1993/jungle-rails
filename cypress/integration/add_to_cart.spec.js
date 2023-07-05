describe("Home page", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});

describe("Add to cart functionality", () => {
  beforeEach(() => {
    cy.seedAndVisit(); 
  });

  it("should increase cart count when adding a product", () => {
    cy.get(".products article").first().within(() => {
      cy.contains("Add to Cart").click(); 
    });

    cy.get(".cart-count").should("contain", "1"); 
  });
});
