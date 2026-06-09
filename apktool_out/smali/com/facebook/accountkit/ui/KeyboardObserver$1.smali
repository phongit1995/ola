.class Lcom/facebook/accountkit/ui/KeyboardObserver$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/KeyboardObserver;->configureGlobalObserver(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/KeyboardObserver;

.field final synthetic val$rootView:Landroid/view/View;

.field final synthetic val$view:Landroid/view/View;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/KeyboardObserver;Landroid/view/View;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/KeyboardObserver$1;->this$0:Lcom/facebook/accountkit/ui/KeyboardObserver;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/KeyboardObserver$1;->val$view:Landroid/view/View;

    iput-object p3, p0, Lcom/facebook/accountkit/ui/KeyboardObserver$1;->val$rootView:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onGlobalLayout()V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/KeyboardObserver$1;->this$0:Lcom/facebook/accountkit/ui/KeyboardObserver;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/KeyboardObserver$1;->val$view:Landroid/view/View;

    iget-object v2, p0, Lcom/facebook/accountkit/ui/KeyboardObserver$1;->val$rootView:Landroid/view/View;

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/ui/KeyboardObserver;->access$000(Lcom/facebook/accountkit/ui/KeyboardObserver;Landroid/view/View;Landroid/view/View;)V

    return-void
.end method
