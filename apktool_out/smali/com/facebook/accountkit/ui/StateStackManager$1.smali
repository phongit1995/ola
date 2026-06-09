.class Lcom/facebook/accountkit/ui/StateStackManager$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/StateStackManager;->getErrorOnPushListener(Ljava/lang/String;)Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/StateStackManager;

.field final synthetic val$errorMessage:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/StateStackManager;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/StateStackManager$1;->this$0:Lcom/facebook/accountkit/ui/StateStackManager;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/StateStackManager$1;->val$errorMessage:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onContentControllerReady(Lcom/facebook/accountkit/ui/ContentController;)V
    .locals 1

    instance-of v0, p1, Lcom/facebook/accountkit/ui/LoginErrorContentController;

    if-eqz v0, :cond_0

    check-cast p1, Lcom/facebook/accountkit/ui/LoginErrorContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/StateStackManager$1;->val$errorMessage:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/LoginErrorContentController;->setErrorMessage(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onContentPushed()V
    .locals 0

    return-void
.end method
