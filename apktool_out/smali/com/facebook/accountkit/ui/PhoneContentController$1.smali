.class Lcom/facebook/accountkit/ui/PhoneContentController$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/PhoneContentController;->setTextFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/PhoneContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/PhoneContentController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getNextButtonText()Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneContentController;->textFragment:Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TextFragment;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController;

    iget-object v1, v1, Lcom/facebook/accountkit/ui/PhoneContentController;->bottomFragment:Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/PhoneContentController$BottomFragment;->getNextButtonTextId()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
