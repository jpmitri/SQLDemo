CREATE TABLE [dbo].[TBL_INC] (
    [STARTER_CODE] NVARCHAR (50) NOT NULL,
    [LAST_VALUE]   BIGINT        NOT NULL,
    [OWNER_ID]     INT           CONSTRAINT [DF_TBL_INC_OWNER_ID] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_TBL_INC] PRIMARY KEY CLUSTERED ([STARTER_CODE] ASC, [OWNER_ID] ASC),
    CONSTRAINT [FK_TBL_INC_TBL_OWNER] FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TBL_OWNER] ([OWNER_ID])
);


GO
