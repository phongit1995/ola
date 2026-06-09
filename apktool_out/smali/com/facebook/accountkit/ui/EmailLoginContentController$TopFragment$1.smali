.class Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


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

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$1;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$1;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$300(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$1;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$300(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;

    move-result-object p1

    invoke-interface {p1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;->onEmailChanged()V

    :cond_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
