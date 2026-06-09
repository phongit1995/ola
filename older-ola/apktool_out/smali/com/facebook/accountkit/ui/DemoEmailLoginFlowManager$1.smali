.class Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->logInWithEmail(Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;

.field final synthetic val$email:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;->this$0:Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;->val$email:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;->val$email:Ljava/lang/String;

    const-string v1, "@example.com"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;->this$0:Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;

    sget-object v2, Lcom/facebook/accountkit/internal/LoginStatus;->PENDING:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-static {v0, v2, v1}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->access$000(Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;Lcom/facebook/accountkit/internal/LoginStatus;Lcom/facebook/accountkit/AccountKitError;)V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1$1;

    invoke-direct {v1, p0}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1$1;-><init>(Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;)V

    const-wide/16 v2, 0x1770

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void

    :cond_0
    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const/16 v2, 0x3a9b

    const-string v3, "[Demo] use *@example.com"

    invoke-direct {v0, v2, v1, v3}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    new-instance v1, Lcom/facebook/accountkit/AccountKitError;

    sget-object v2, Lcom/facebook/accountkit/AccountKitError$Type;->ARGUMENT_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    invoke-direct {v1, v2, v0}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;->this$0:Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;

    sget-object v2, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    invoke-static {v0, v2, v1}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->access$000(Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;Lcom/facebook/accountkit/internal/LoginStatus;Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method
