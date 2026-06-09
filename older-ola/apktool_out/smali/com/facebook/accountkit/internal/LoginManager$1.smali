.class Lcom/facebook/accountkit/internal/LoginManager$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/SeamlessLoginClient$CompletedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/LoginManager;->initializeLogin()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/LoginManager;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/LoginManager;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/LoginManager$1;->this$0:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public completed(Landroid/os/Bundle;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/LoginManager$1;->this$0:Lcom/facebook/accountkit/internal/LoginManager;

    invoke-static {v0, p1}, Lcom/facebook/accountkit/internal/LoginManager;->access$000(Lcom/facebook/accountkit/internal/LoginManager;Landroid/os/Bundle;)V

    return-void
.end method
