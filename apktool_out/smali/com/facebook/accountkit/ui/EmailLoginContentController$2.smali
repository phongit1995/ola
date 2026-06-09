.class Lcom/facebook/accountkit/ui/EmailLoginContentController$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/EmailLoginContentController$TopFragment$OnEmailChangedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/EmailLoginContentController;->setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
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

    iput-object p1, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$2;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEmailChanged()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/EmailLoginContentController$2;->this$0:Lcom/facebook/accountkit/ui/EmailLoginContentController;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/EmailLoginContentController;->access$800(Lcom/facebook/accountkit/ui/EmailLoginContentController;)V

    return-void
.end method
