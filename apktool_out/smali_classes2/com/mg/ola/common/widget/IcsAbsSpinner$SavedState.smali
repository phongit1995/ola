.class Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;
.super Landroid/view/View$BaseSavedState;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/IcsAbsSpinner;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "SavedState"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field a:J

.field b:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState$1;

    invoke-direct {v0}, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState$1;-><init>()V

    sput-object v0, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 2

    invoke-direct {p0, p1}, Landroid/view/View$BaseSavedState;-><init>(Landroid/os/Parcel;)V

    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->a:J

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->b:I

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/mg/ola/common/widget/IcsAbsSpinner$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method constructor <init>(Landroid/os/Parcelable;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/view/View$BaseSavedState;-><init>(Landroid/os/Parcelable;)V

    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AbsSpinner.SavedState{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " selectedId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->a:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, " position="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2

    invoke-super {p0, p1, p2}, Landroid/view/View$BaseSavedState;->writeToParcel(Landroid/os/Parcel;I)V

    iget-wide v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->a:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget p2, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$SavedState;->b:I

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    return-void
.end method
