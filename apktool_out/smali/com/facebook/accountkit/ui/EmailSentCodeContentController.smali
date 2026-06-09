.class final Lcom/facebook/accountkit/ui/EmailSentCodeContentController;
.super Lcom/facebook/accountkit/ui/SentCodeContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/SentCodeContentController;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    return-void
.end method


# virtual methods
.method protected logImpression()V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/ui/LoginType;->EMAIL:Lcom/facebook/accountkit/ui/LoginType;

    const/4 v1, 0x1

    invoke-static {v1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUISentCode(ZLcom/facebook/accountkit/ui/LoginType;)V

    return-void
.end method
