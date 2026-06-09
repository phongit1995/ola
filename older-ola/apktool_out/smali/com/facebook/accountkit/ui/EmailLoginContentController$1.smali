.class Lcom/facebook/accountkit/ui/EmailLoginContentController$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/TextContentFragment$NextButtonTextProvider;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/EmailLoginContentController;->setTextFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/EmailLoginContentController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getNextButtonText()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$600(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$BottomFragment;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$700(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$TextFragment;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TextFragment;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$1;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$600(Lcom/facebook/accountkit/ui/EmailLoginContentController;)Lcom/facebook/accountkit/ui/EmailLoginContentController$BottomFragment;

    move-result-object v1

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/EmailLoginContentController$BottomFragment;->getNextButtonTextId()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
