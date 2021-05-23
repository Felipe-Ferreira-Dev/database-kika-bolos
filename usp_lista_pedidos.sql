
SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'usp_lista_pedidos') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE usp_lista_pedidos
GO
/*
-------------------------------------------------------------------------------------------------------------------------------------- 
    
    NOME:      usp_lista_pedidos
    AUTOR:     FELIPE FERREIRA
    DATA:      19/05/2021
    DESCRICAO: Retorna codigo, nome do cliente, nome e produto e valor total do pedido
----------------------------------------------------------------------------------------------------------------------------------
    PARAMETROS:
         @nomeServico VARCHAR(30)

    EXEMPLO DE EXECUCAO:
        EXEC usp_lista_pedidos @COD_USUARIO = 2

--------------------------------------------------------------------------------------------------------------------------------------
ALTERACOES:
    


--------------------------------------------------------------------------------------------------------------------------------------
*/

CREATE PROCEDURE usp_lista_pedidos(
    @COD_USUARIO INTEGER
)
AS
BEGIN
    SET NOCOUNT ON


    SELECT
        PD.COD_PEDIDO AS CODIGO_PEDIDO,
        US.NOME AS NOME_USUARIO,
        PR.NOME AS NOME_PRODUTO,
        PD.QUANTIDADE AS QUANTIDADE,
        CAST((PR.PRECO*PD.QUANTIDADE) AS DECIMAL(8,2)) AS VALOR_TOTAL
    FROM 
        PEDIDO PD WITH(NOLOCK)
        INNER JOIN PRODUTO PR WITH(NOLOCK)
            ON PD.COD_PRODUTO = PR.COD_PRODUTO
        INNER JOIN USUARIO US WITH(NOLOCK)
            ON PD.COD_USUARIO = US.COD_USUARIO
    WHERE
        US.COD_USUARIO = @COD_USUARIO
	ORDER BY
		PD.COD_PEDIDO DESC

END
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO


GRANT EXECUTE ON usp_lista_pedidos TO ecommerce
GO

