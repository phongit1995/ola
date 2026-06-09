.class Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->access$200(Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;)Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->access$200(Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;)Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    move-result-object v0

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    sget-object v1, Lcom/facebook/accountkit/ui/Buttons;->PHONE_LOGIN_NEXT:Lcom/facebook/accountkit/ui/Buttons;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/Buttons;->name()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;->onNext(Landroid/content/Context;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
