.class Lcom/facebook/accountkit/internal/EmailLoginController$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/EmailLoginController$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/facebook/accountkit/internal/EmailLoginController$2;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/EmailLoginController$2;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2$1;->this$1:Lcom/facebook/accountkit/internal/EmailLoginController$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginController$2$1;->this$1:Lcom/facebook/accountkit/internal/EmailLoginController$2;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/EmailLoginController$2;->val$callback:Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;->onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V

    return-void
.end method
