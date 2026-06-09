.class public Lbolts/j$a;
.super Lbolts/k;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lbolts/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lbolts/k<",
        "TTResult;>;"
    }
.end annotation


# instance fields
.field final synthetic a:Lbolts/j;


# direct methods
.method constructor <init>(Lbolts/j;)V
    .locals 0

    iput-object p1, p0, Lbolts/j$a;->a:Lbolts/j;

    invoke-direct {p0}, Lbolts/k;-><init>()V

    return-void
.end method
