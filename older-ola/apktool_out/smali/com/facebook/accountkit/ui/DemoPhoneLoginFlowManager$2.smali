.class Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;->setConfirmationCode(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;

.field final synthetic val$confirmationCode:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$2;->this$0:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$2;->val$confirmationCode:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$2;->val$confirmationCode:Ljava/lang/String;

    const-string v1, "123456"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$2;->this$0:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;

    sget-object v2, Lcom/facebook/accountkit/internal/LoginStatus;->SUCCESS:Lcom/facebook/accountkit/internal/LoginStatus;

    :goto_0
    invoke-static {v0, v2, v1}, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;->access$000(Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;Lcom/facebook/accountkit/internal/LoginStatus;Lcom/facebook/accountkit/AccountKitError;)V

    return-void

    :cond_0
    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const v2, 0x1db962

    const-string v3, "[Demo] use confirmation code 123456"

    invoke-direct {v0, v2, v1, v3}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    new-instance v1, Lcom/facebook/accountkit/AccountKitError;

    sget-object v2, Lcom/facebook/accountkit/AccountKitError$Type;->ARGUMENT_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    invoke-direct {v1, v2, v0}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$2;->this$0:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;

    sget-object v2, Lcom/facebook/accountkit/internal/LoginStatus;->ERROR:Lcom/facebook/accountkit/internal/LoginStatus;

    goto :goto_0

    return-void
.end method
