describe('FilmRepository', () => {
  it('should return a list of films', () => {
    cy.visit('http://localhost:3000/');
    cy.get('.grid-cols-1').find('.flex.flex-col.items-center').should('have.length', 10);
  });
});
