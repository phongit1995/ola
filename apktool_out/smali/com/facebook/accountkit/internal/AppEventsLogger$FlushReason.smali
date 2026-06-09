.class final enum Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/internal/AppEventsLogger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "FlushReason"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

.field public static final enum EAGER_FLUSHING_EVENT:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

.field public static final enum EVENT_THRESHOLD:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

.field public static final enum EXPLICIT:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

.field public static final enum PERSISTED_EVENTS:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

.field public static final enum SESSION_CHANGE:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

.field public static final enum TIMER:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    const-string v1, "EXPLICIT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->EXPLICIT:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    const-string v1, "TIMER"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->TIMER:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    const-string v1, "SESSION_CHANGE"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->SESSION_CHANGE:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    const-string v1, "PERSISTED_EVENTS"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->PERSISTED_EVENTS:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    const-string v1, "EVENT_THRESHOLD"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->EVENT_THRESHOLD:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    const-string v1, "EAGER_FLUSHING_EVENT"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7}, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->EAGER_FLUSHING_EVENT:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    const/4 v0, 0x6

    new-array v0, v0, [Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->EXPLICIT:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->TIMER:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->SESSION_CHANGE:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->PERSISTED_EVENTS:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    aput-object v1, v0, v5

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->EVENT_THRESHOLD:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    aput-object v1, v0, v6

    sget-object v1, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->EAGER_FLUSHING_EVENT:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    aput-object v1, v0, v7

    sput-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->$VALUES:[Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->$VALUES:[Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/internal/AppEventsLogger$FlushReason;

    return-object v0
.end method
