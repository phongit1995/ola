.class Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->getResendOnPushListener()Lcom/facebook/accountkit/ui/StateStackManager$OnPushListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

.field final synthetic val$phoneLoginModel:Lcom/facebook/accountkit/PhoneLoginModel;

.field final synthetic val$phoneNumber:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ActivityPhoneHandler;Ljava/lang/String;Lcom/facebook/accountkit/PhoneLoginModel;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;->this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;->val$phoneNumber:Ljava/lang/String;

    iput-object p3, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;->val$phoneLoginModel:Lcom/facebook/accountkit/PhoneLoginModel;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onContentControllerReady(Lcom/facebook/accountkit/ui/ContentController;)V
    .locals 2

    instance-of v0, p1, Lcom/facebook/accountkit/ui/ResendContentController;

    if-eqz v0, :cond_0

    check-cast p1, Lcom/facebook/accountkit/ui/ResendContentController;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;->val$phoneNumber:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/ResendContentController;->setPhoneNumber(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;->this$0:Lcom/facebook/accountkit/ui/ActivityPhoneHandler;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler;->configuration:Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->getNotificationChannels()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/facebook/accountkit/ui/ResendContentController;->setNotificationChannels(Ljava/util/List;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityPhoneHandler$2;->val$phoneLoginModel:Lcom/facebook/accountkit/PhoneLoginModel;

    invoke-interface {v0}, Lcom/facebook/accountkit/PhoneLoginModel;->getResendTime()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lcom/facebook/accountkit/ui/ResendContentController;->setResendTime(J)V

    :cond_0
    return-void
.end method

.method public onContentPushed()V
    .locals 0

    return-void
.end method
