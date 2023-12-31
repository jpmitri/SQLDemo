CREATE TABLE [dbo].[TBL_CLIENT] (
    [CLIENT_ID]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [NAME]          NVARCHAR (50)  NOT NULL,
    [FAMILY_NAME]   NVARCHAR (50)  NOT NULL,
    [DOB]           DATE           NOT NULL,
    [ENTRY_USER_ID] BIGINT         NOT NULL,
    [ENTRY_DATE]    DATE           CONSTRAINT [DF_TBL_CLIENT_ENTRY_DATE] DEFAULT (getdate()) NOT NULL,
    [OWNER_ID]      INT            NOT NULL,
    [FTS]           NVARCHAR (MAX) DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_TBL_CLIENT] PRIMARY KEY CLUSTERED ([CLIENT_ID] ASC),
    CONSTRAINT [FK_TBL_CLIENT_TBL_OWNER] FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TBL_OWNER] ([OWNER_ID]),
    CONSTRAINT [FK_TBL_CLIENT_TBL_USER] FOREIGN KEY ([ENTRY_USER_ID]) REFERENCES [dbo].[TBL_USER] ([USER_ID])
);


GO

CREATE NONCLUSTERED INDEX [IX_OWNER_ID]
    ON [dbo].[TBL_CLIENT]([OWNER_ID] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_ENTRY_USER_ID]
    ON [dbo].[TBL_CLIENT]([ENTRY_USER_ID] ASC);


GO

CREATE FULLTEXT INDEX ON [dbo].[TBL_CLIENT]
    ([FTS] LANGUAGE 1033)
    KEY INDEX [PK_TBL_CLIENT]
    ON [UCAT_01];


GO

