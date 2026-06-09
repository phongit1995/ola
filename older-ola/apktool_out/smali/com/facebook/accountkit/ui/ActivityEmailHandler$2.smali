.class Lcom/facebook/accountkit/ui/ActivityEmailHandler$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/StateStackManager$OnPopListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/ActivityEmailHandler;->onEmailVerifyRetry(Lcom/facebook/accountkit/ui/AccountKitActivity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/ActivityEmailHandler;

.field final synthetic val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/ActivityEmailHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ActivityEmailHandler$2;->this$0:Lcom/facebook/accountkit/ui/ActivityEmailHandler;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/ActivityEmailHandler$2;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onContentPopped()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ActivityEmailHandler$2;->this$0:Lcom/facebook/accountkit/ui/ActivityEmailHandler;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/ActivityEmailHandler$2;->val$activity:Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/ActivityEmailHandler;->access$100(Lcom/facebook/accountkit/ui/ActivityEmailHandler;Lcom/facebook/accountkit/ui/AccountKitActivity;)V

    return-void
.end method
