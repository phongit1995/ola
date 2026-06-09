.class Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnKeyListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onKey(Landroid/view/View;ILandroid/view/KeyEvent;)Z
    .locals 2

    check-cast p1, Landroid/widget/EditText;

    const/4 v0, 0x1

    const/4 v1, 0x7

    if-lt p2, v1, :cond_0

    const/16 v1, 0x10

    if-gt p2, v1, :cond_0

    invoke-virtual {p3}, Landroid/view/KeyEvent;->getAction()I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p3}, Landroid/view/KeyEvent;->getUnicodeChar()I

    move-result p2

    int-to-char p2, p2

    invoke-static {p2}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return v0

    :cond_0
    const/16 v1, 0x43

    if-ne p2, v1, :cond_3

    invoke-virtual {p3}, Landroid/view/KeyEvent;->getAction()I

    move-result p2

    if-nez p2, :cond_3

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-interface {p2}, Landroid/text/Editable;->length()I

    move-result p2

    if-nez p2, :cond_1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-static {p2, p1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->access$200(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;Landroid/view/View;)Landroid/widget/EditText;

    move-result-object p1

    if-eqz p1, :cond_2

    :cond_1
    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_2
    return v0

    :cond_3
    const/4 p1, 0x0

    return p1
.end method
