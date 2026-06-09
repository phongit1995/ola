.class Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/internal/AppEventsLogger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FlushStatistics"
.end annotation


# instance fields
.field numEvents:I

.field public result:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;->numEvents:I

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;->SUCCESS:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;->result:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushResult;

    return-void
.end method

.method synthetic constructor <init>(Lcom/facebook/accountkit/internal/AppEventsLogger$1;)V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;-><init>()V

    return-void
.end method
