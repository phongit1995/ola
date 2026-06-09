.class Lcom/facebook/accountkit/ui/AccountKitActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/AccountKitActivity;->resetFlowTo(Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginFlowState;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$2;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onContentPopped()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$2;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitActivity;->getContentController()Lcom/facebook/accountkit/ui/ContentController;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/AccountKitActivity$2;->this$0:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-interface {v0, v1}, Lcom/facebook/accountkit/ui/ContentController;->onResume(Landroid/app/Activity;)V

    return-void
.end method
