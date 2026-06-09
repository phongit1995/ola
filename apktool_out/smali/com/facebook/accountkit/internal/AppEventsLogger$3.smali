.class Lcom/facebook/accountkit/internal/AppEventsLogger$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/AppEventsLogger;->logSdkEvent(Ljava/lang/String;Ljava/lang/Double;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

.field final synthetic val$event:Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$3;->this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$3;->val$event:Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$3;->this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$3;->this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

    invoke-static {v1}, Lcom/facebook/accountkit/internal/AppEventsLogger;->access$200(Lcom/facebook/accountkit/internal/AppEventsLogger;)Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/facebook/accountkit/internal/AppEventsLogger;->access$300(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;)Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$3;->val$event:Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;->addEvent(Lcom/facebook/accountkit/internal/AppEventsLogger$AppEvent;)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$3;->this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AppEventsLogger;->access$400(Lcom/facebook/accountkit/internal/AppEventsLogger;)V

    return-void
.end method
