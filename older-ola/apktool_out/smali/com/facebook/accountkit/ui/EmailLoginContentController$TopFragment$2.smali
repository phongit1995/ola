.class Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p3, 0x5

    if-ne p2, p3, :cond_1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->getEmail()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$400(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;

    move-result-object p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$400(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;

    move-result-object p2

    invoke-virtual {p1}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object p1

    sget-object p3, Lcom/facebook/accountkit/ui/Buttons;->EMAIL_LOGIN_NEXT_KEYBOARD:Lcom/facebook/accountkit/ui/Buttons;

    invoke-virtual {p3}, Lcom/facebook/accountkit/ui/Buttons;->name()Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2, p1, p3}, Lcom/facebook/accountkit/ui/EmailLoginContentController$OnCompleteListener;->onNext(Landroid/content/Context;Ljava/lang/String;)V

    :cond_0
    const/4 p1, 0x1

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method
