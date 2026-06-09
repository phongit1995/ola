.class Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->fillEmail()V
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

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    iget-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    iget-object p2, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$3;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;

    invoke-static {p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->access$500(Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;)Landroid/widget/AutoCompleteTextView;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/AutoCompleteTextView;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment;->setSelectedEmail(Ljava/lang/String;)V

    return-void
.end method
