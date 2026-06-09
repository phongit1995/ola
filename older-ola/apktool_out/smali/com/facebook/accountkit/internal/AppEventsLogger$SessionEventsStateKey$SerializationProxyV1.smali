.class Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey$SerializationProxyV1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SerializationProxyV1"
.end annotation


# static fields
.field private static final serialVersionUID:J = -0x1L


# instance fields
.field private final accessTokenString:Ljava/lang/String;

.field private final appId:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey$SerializationProxyV1;->accessTokenString:Ljava/lang/String;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey$SerializationProxyV1;->appId:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/internal/AppEventsLogger$1;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey$SerializationProxyV1;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private readResolve()Ljava/lang/Object;
    .locals 3

    new-instance v0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey$SerializationProxyV1;->accessTokenString:Ljava/lang/String;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey$SerializationProxyV1;->appId:Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method
