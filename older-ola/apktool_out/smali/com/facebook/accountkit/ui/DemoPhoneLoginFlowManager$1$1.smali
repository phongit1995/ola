.class Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1$1;->this$1:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1$1;->this$1:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;->this$0:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;->access$200(Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;)Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1$1;->this$1:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;

    iget-object v1, v1, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;->this$0:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;

    invoke-static {v1}, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;->access$100(Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;)Lcom/facebook/accountkit/ui/AccountKitActivity;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->startSmsTrackerIfPossible(Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1$1;->this$1:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager$1;->this$0:Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;->access$200(Lcom/facebook/accountkit/ui/DemoPhoneLoginFlowManager;)Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getSmsTracker()Lcom/facebook/accountkit/ui/SmsTracker;

    move-result-object v0

    const-string v1, "123456"

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/SmsTracker;->confirmationCodeReceived(Ljava/lang/String;)V

    return-void
.end method
