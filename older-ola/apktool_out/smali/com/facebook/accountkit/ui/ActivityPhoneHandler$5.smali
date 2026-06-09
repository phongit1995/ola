.class Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->onResendFacebookNotification(Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

.field final synthetic val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

.field final synthetic val$phoneManager:Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

.field final synthetic val$phoneNumber:Lcom/facebook/accountkit/PhoneNumber;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;->this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    iput-object p3, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;->val$phoneManager:Lcom/facebook/accountkit/ui/PhoneLoginFlowManager;

    iput-object p4, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;->val$phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onContentPopped()V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->SENT_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v2, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5$1;

    invoke-direct {v2, p0}, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5$1;-><init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler$5;)V

    invoke-virtual {v0, v1, v2}, Lcom/facebook/accountkit/ui/AccountKitActivity;->popBackStack(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;)V

    return-void
.end method
