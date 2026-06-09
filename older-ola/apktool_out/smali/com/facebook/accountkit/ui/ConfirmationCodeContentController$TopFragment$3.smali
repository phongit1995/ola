.class Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$3;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;


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

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$3;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTextPaste()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$3;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;->access$300(Landroid/content/Context;)[C

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$3;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-static {v1}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->access$400(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)[Landroid/widget/EditText;

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment$3;->this$0:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;

    invoke-static {v2}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;->access$400(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TopFragment;)[Landroid/widget/EditText;

    move-result-object v2

    aget-object v2, v2, v1

    aget-char v3, v0, v1

    invoke-static {v3}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method
