.class Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment$1;->this$0:Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/Buttons;->SEND_NEW_EMAIL:Lcom/facebook/accountkit/ui/Buttons;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/Buttons;->name()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIEmailVerifyInteraction(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment$1;->this$0:Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;->access$100(Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;)Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment$OnCompleteListener;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment$1;->this$0:Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;->access$100(Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment;)Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment$OnCompleteListener;

    move-result-object v0

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/facebook/accountkit/ui/EmailVerifyContentController$BottomFragment$OnCompleteListener;->onRetry(Landroid/content/Context;)V

    :cond_0
    return-void
.end method
