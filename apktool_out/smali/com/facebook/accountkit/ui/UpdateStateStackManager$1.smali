.class Lcom/facebook/accountkit/ui/UpdateStateStackManager$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/UpdateStateStackManager;->onReceive(Landroid/content/Context;Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

.field final synthetic val$finalUpdateState:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/UpdateStateStackManager;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager$1;->this$0:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager$1;->val$finalUpdateState:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager$1;->this$0:Lcom/facebook/accountkit/ui/UpdateStateStackManager;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/UpdateStateStackManager$1;->val$finalUpdateState:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/ui/UpdateStateStackManager;->access$000(Lcom/facebook/accountkit/ui/UpdateStateStackManager;Ljava/lang/String;)V

    return-void
.end method
