.class Lcom/facebook/accountkit/internal/AppEventsLogger$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/AppEventsLogger;->initializeTimersIfNeeded()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/AppEventsLogger;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$4;->this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$4;->this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->TIMER:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    invoke-static {v0, v1}, Lcom/facebook/accountkit/internal/AppEventsLogger;->access$500(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;)V

    return-void
.end method
